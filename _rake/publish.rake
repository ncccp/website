desc "Generate website and deploy"
  task :publish => [:integrate, :generate, :deploy] do
end