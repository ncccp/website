heroku_dir  = "_heroku"   # deploy directory (for Github pages deployment)
public_dir      = "public"    # compiled site directory

deploy_branch  = "master"

desc "deploy basic rack app to heroku"
  multitask :heroku do
    puts "## Deploying to Heroku "
    (Dir["#{heroku_dir}/public/*"]).each { |f| rm_rf(f) }
    system "cp -R #{public_dir}/* #{heroku_dir}/public"
    puts "\n## copying #{public_dir} to #{heroku_dir}/public"
    cd "#{heroku_dir}" do
      system "git add ."
      system "git add -u"
      puts "\n## Committing: Site updated at #{Time.now.utc}"
      message = "Site updated at #{Time.now.utc}"
      system "git commit -m '#{message}'"
      puts "\n## Pushing generated #{heroku_dir} website"
      system "git push heroku #{deploy_branch}"
      puts "\n## Heroku deploy complete"
    end
  end