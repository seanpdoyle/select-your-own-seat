import { Controller } from "stimulus"

export default class extends Controller {
  requested(event) {
    const fragmentTarget = event.target.getAttribute("data-fragment-target")

    if (fragmentTarget) {
      this.data.set("requested", fragmentTarget)
    }
  }

  setHeaders(event) {
    if (this.data.has("requested")) {
      const xhr = event.data.xhr
      xhr.setRequestHeader("X_FRAGMENT", true)
      xhr.setRequestHeader("X-Fragment", true)
    }
  }

  responded(event) {
    const fragmentTarget = this.data.get("requested")
    const newBody = event.data.newBody

    if (fragmentTarget === "dialog") {
      const main = newBody.querySelector("main")

      main.insertAdjacentHTML("afterend", this.data.get("responded"))
    }
  }
}
