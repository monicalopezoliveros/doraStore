# Pin npm packages by running ./bin/importmap

pin "application"

pin "@hotwired/turbo-rails", to: "vendor/javascript/@hotwired/turbo-rails.js" # @8.0.12
pin "@rails/ujs", to: "vendor/javascript/@rails/ujs.js" # @7.1.3

pin "@hotwired/stimulus", to: "vendor/javascript/stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "vendor/javascript/stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@hotwired/turbo", to: "vendor/javascript/@hotwired/turbo.js" # @8.0.12
pin "@rails/actioncable/src", to: "vendor/javascript/@rails/actioncable/src.js" # @7.2.200
