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
      xhr.setRequestHeader("X-Fragment", true)
    }
  }

  responded(event) {
    const fragmentTarget = this.data.get("requested")

    this.data.delete("requested")

    if (fragmentTarget === "dialog") {
      const main = document.body.querySelector("main")

      main.insertAdjacentHTML("afterend", event.data.newBody.innerHTML)

      event.data.newBody.innerHTML = document.body.outerHTML
    }
  }
}
