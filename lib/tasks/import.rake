namespace :import do
  desc "Generates provider CSV file"
  task :provider_csv, :infile, :outfile do |t, args|
    args.with_defaults(:infile => "Medicare-Physician-and-Other-Supplier-PUF-CY2012.txt",:outfile => "cms_2012_providers.csv")
    puts "using infile #{args.infile}, outfile #{args.outfile}"
    output = File.open(args.outfile, "w+")

    cmsfile = "#{args.infile}"
    rowcount = 0
    providers = Hash.new
    File.foreach(cmsfile) do |line|
      rowcount += 1
      #skip AMA copyright
      next if rowcount == 2
			l = line.split("\t")

      @npi = l[0]
      next if providers[@npi]
      @nppes_provider_last_org_name = l[1]
      @nppes_provider_first_name = l[2]
      @nppes_provider_mi = l[3]
      @nppes_credentials  = l[4]
      @nppes_provider_gender  = l[5]
      @nppes_entity_code = l[6]
      @nppes_provider_street1 = l[7]
      @nppes_provider_street2 = l[8]
      @nppes_provider_city = l[9]
      @nppes_provider_zip = l[10]
      @nppes_provider_state = l[11]
      @nppes_provider_country = l[12]
      @provider_type  = l[13]
      @medicare_participation_indicator  = l[14]
      @place_of_Service = l[15]
      @hcpcs_code = l[16]
      @hcpcs_description  = l[17]
      @line_srvc_cnt  = l[18]
      @bene_unique_cnt  = l[19]
      @bene_day_srvc_cnt  = l[20]
      @average_Medicare_allowed_amt = l[21]
      @stdev_Medicare_allowed_amt  = l[22]
      @average_submitted_chrg_amt  = l[23]
      @stdev_submitted_chrg_amt  = l[24]
      @average_Medicare_payment_amt  = l[25]
      @stdev_Medicare_payment_amt = l[26]

      output.puts "#{@npi},#{@nppes_provider_last_org_name},#{@nppes_provider_street1},#{@nppes_provider_street2},#{@nppes_provider_city},#{@nppes_provider_zip},#{@nppes_provider_state},#{@nppes_provider_country}"
      providers[@npi] = @nppes_provider_last_org_name
      #if provider isn't present, add

      #geocode address

      #add service
    end
    output.close
    infile.close
    puts "done"

  end
  
  desc "Add summary specialty info"

 desc "Imports data from CMS file to database"
  task :cms_data, :infile do |t, args|
    args.with_defaults(:infile => "Medicare-Physician-and-Other-Supplier-PUF-CY2012.txt")
    puts "using infile #{args.infile}"
    Rake::Task[:environment].invoke

    cmsfile = "#{args.infile}"
    rowcount = 0

    File.foreach(cmsfile) do |line|
      rowcount += 1
      #skip the header row and the AMA copyright
      next if rowcount <= 2
      l = line.split("\t")

      npi = l[0]
      prov = Provider.find_by_npi(npi)

      #if we don't know this provider, create
      if prov.nil?
        prov = Provider.new
        prov.npi = npi
        prov.last_org_name = l[1]
        prov.first_name = l[2]
        prov.mi = l[3]
        prov.credentials  = l[4]
        prov.gender  = l[5]
        prov.entity_code = l[6]
        prov.street1 = l[7]
        prov.street2 = l[8]
        prov.city = l[9]
        prov.zip = l[10]
        prov.state = l[11]
        prov.country = l[12]
        prov.specialty  = l[13]
        prov.mc_participation = l[14]
        prov.save
      end

      #add payment
      pmt = Payment.new
      pmt.provider = prov
      pmt.place_of_service = l[15]
      pmt.hcpcs_code = l[16]
      hcpcs_description  = l[17]
      pmt.line_srvc_cnt  = l[18]
      pmt.bene_unique_cnt  = l[19]
      pmt.bene_day_srvc_cnt  = l[20]
      pmt.avg_mc_allowed_amt = l[21]
      pmt.stdev_mc_allowed_amt  = l[22]
      pmt.avg_sub_chrg_amt  = l[23]
      pmt.stdev_sub_chrg_amt  = l[24]
      pmt.avg_mc_pmt_amt  = l[25]
      pmt.stdev_mc_pmt_amt = l[26]
      pmt.save

      #hcpcs code
      thecode = Hcpcs.find_by code:pmt.hcpcs_code
      if thecode.nil?
        thecode = Hcpcs.new
        thecode.code = pmt.hcpcs_code
        thecode.description = hcpcs_description
        thecode.save
      end
    end

    puts "imported #{rowcount} rows"

  end

  desc "Creates specialty summary"
  task :specialties => :environment do
    sql = "select specialty, count(specialty), max(total_pmt), avg(total_pmt), sum(total_pmt)
           from providers
           group by specialty
           order by specialty;"
    response = ActiveRecord::Base.connection.execute(sql)
    Specialty.delete_all;
    specialtyinfo = []
    response.each do |r|
      puts "Importing #{r[0]}"
      Specialty.new(:name => r[0], :count => r[1], :max_pmt => r[2], :avg_pmt => r[3], :total_pmt => r[4]).save()
    end
  end
end
