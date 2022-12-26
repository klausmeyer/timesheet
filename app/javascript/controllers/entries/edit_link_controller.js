import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  click() {
    document.scrollingElement.scrollTo(0, 0)
  }
}
