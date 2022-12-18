import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select"]

  change() {
    let frame = document.getElementById("add_entry")

    frame.src = `/entries/new?type=${this.selectTarget.value}`
  }
}
