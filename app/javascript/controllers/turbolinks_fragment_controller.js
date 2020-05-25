import { Controller } from "stimulus"

export default class extends Controller {
  click(event) {
    const request = event.target.getAttribute("data-turbolinks-fragment")

    if (request) {
      this.data.set("request", request)
    }
  }

  appendHeader(event) {
    const request = this.data.get("request")

    if (request) {
      event.data.xhr.setRequestHeader("X-Turbolinks-Fragment", request)
    }

    this.data.remove("request")
  }

  injectFragment(event) {
    const request = this.data.get("request")

    if (request) {
      const documentBody = this.element.cloneNode(true)
      const responseBody = event.data.newBody
      const channelsInDocumentBody = documentBody.querySelectorAll(
        `[data-turbolinks-fragment-channel~="${request}"]`
      )

      for (const channel of channelsInDocumentBody) {
        channel.innerHTML      = responseBody.innerHTML
        responseBody.innerHTML = documentBody.innerHTML
      }
    }
  }
}
