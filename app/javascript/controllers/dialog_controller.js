import { Controller } from "stimulus"
import Turbolinks from "turbolinks"
import dialogPolyfill from "dialog-polyfill"

export default class extends Controller {
  connect() {
    const noscriptClass = this.data.get("noscriptClass")
    const noscriptBackdrop = this.data.get("noscriptBackdrop")

    dialogPolyfill.registerDialog(this.element)

    if (this.element.hasAttribute("open")) {
      for (const backdrop of this.element.parentElement.querySelectorAll(noscriptBackdrop)) {
        backdrop.remove()
      }

      this.element.open = false
      this.element.classList.remove(noscriptClass)
      this.element.showModal()
    }
  }

  cancel({ currentTarget }) {
    const redirectToUrl = this.data.get("redirectToUrl")

    Turbolinks.visit(redirectToUrl, { action: "replace" })
  }
}
