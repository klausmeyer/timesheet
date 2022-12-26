import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select"]

  change() {
    let frame = this.selectTarget.closest("#entry")
    let path = frame.src.split("?")[0]

    frame.src = `${path}?type=${this.selectTarget.value}`
    frame.reload()
  }
}
