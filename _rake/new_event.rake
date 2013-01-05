posts_dir       = "_posts"    # directory for blog files
source_dir      = "source"    # source file directory
new_post_ext    = "markdown"  # default new post file extension when using the new_post task

# usage rake new_event[my-new-event] or rake new_event['my new event'] or rake new_event (defaults to "new-event")
desc "Begin a new event in #{source_dir}/#{posts_dir}"
task :new_event, :title do |t, args|
  if args.title
    title = args.title
  else
    title = get_stdin("Enter a title for your post: ")
  end
  raise "### You haven't set anything up yet. First run `rake install` to set up an Octopress theme." unless File.directory?(source_dir)
  mkdir_p "#{source_dir}/#{posts_dir}"
  filename = "#{source_dir}/#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.#{new_post_ext}"
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M')}"
    post.puts "comments: true"
    post.puts "external-url: "
    post.puts "categories: "
    post.puts "---"
  end
end