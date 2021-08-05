import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
require('jquery')
require ('bootstrap-sprockets')
import 'bootstrap'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
