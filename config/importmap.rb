# Pin npm packages by running ./bin/importmap

pin "application"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.2/dist/esm/index.js" # use unpkg.com as ga.jspm.io contains a broken popper package
pin "application", preload: true
pin "tom-select", to: "https://ga.jspm.io/npm:tom-select@2.2.2/dist/js/tom-select.complete.js"
# config/importmap.rb
pin "@hotwired/turbo-rails", to: "https://cdn.jsdelivr.net/npm/@hotwired/turbo@7.2.0/dist/turbo.es2017-esm.js", preload: true
pin "@hotwired/stimulus", to: "https://cdn.jsdelivr.net/npm/@hotwired/stimulus@3.2.1/dist/stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

pin "controllers/application", to: "controllers/application.js"
pin "controllers/hello_controller", to: "controllers/hello_controller.js"
pin "controllers/premium_controller", to: "controllers/premium_controller.js"
pin "controllers/index", to: "controllers/index.js"
