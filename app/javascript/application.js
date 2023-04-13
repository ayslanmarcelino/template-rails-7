// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import Swal from 'sweetalert2';
import '../../lib/assets/javascripts/confirm';
import '../../lib/assets/javascripts/masks';
import 'chartkick/chart.js'

window.Swal = Swal;
