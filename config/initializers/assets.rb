# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( filterrific/filterrific-spinner.gif )
Rails.application.config.assets.paths << Rails.root.join('app', 'vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.svg)
Rails.application.config.assets.precompile += %w( *.js ^[^_]*.css *.css.erb *.css.scss )
Rails.application.config.assets.precompile += %w( epidemic_sheets/* *.js )
Rails.application.config.assets.precompile += %w( application.js )
Rails.application.config.assets.precompile += %w( sifaho-bg.png )
Rails.application.config.assets.precompile += %w( welcome.css )
Rails.application.config.assets.precompile += %w( prescriptions.scss )
Rails.application.config.assets.precompile += %w( scaffolds.css.erb )
Rails.application.config.assets.precompile += %w( variables.scss )
Rails.application.config.assets.precompile += %w( sidebar.scss )
