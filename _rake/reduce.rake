require "reduce"

public_dir  = "public"    # compiled site directory

desc "minifies static files"
task :minify do
  puts "## Compressing static assets"
  original = 0.0
  compressed = 0 
  Dir.glob("#{public_dir}/**/*.*") do |file|
    case File.extname(file)
      when '.html', '.js', '.css', '.png', '.jpg', '.jpeg', '.gif', '.xml'
        puts "processing: #{file}"
        original += File.size(file).to_f
        min = Reduce.reduce(file)
        File.open(file, "w") do |f|
          f.write(min)
        end
        compressed += File.size(file)
      else
        puts "skipping: #{file}"
      end
  end
  puts "Total compression %0.2f\%" % (((original-compressed)/original)*100)
end