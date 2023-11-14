import { Controller } from "@hotwired/stimulus"

// Exporting a Stimulus controller class.
export default class extends Controller {
  // The connect() method is called when the controller is connected to an element in the DOM.
  connect() {
    // Set the text content of the connected element to "Hello World!".
    this.element.textContent = "Hello World!"
  }
}