namespace :import do
  desc "Imports data from the CMS PUF"
  task :cms_data, :filename do |t, args|
    args.with_defaults(:filename => "Medicare-Physician-and-Other-Supplier-PUF-CY2012.txt")
    puts "using filename #{args.filename}"
  end


end
