import "details-element-polyfill"
import Turbolinks from "turbolinks"

Turbolinks.start()

const scrollToCurrentCommit = (element) => {
  for (const current of element.querySelectorAll('[aria-current="page"]')) {
    current.scrollIntoView({ block: "center", inline: "center" })
  }
}

document.addEventListener("turbolinks:load", () => {
  for (const details of document.querySelectorAll('details[data-controller*="commit-history"]')) {
    details.addEventListener("toggle", (event) => {
      if (details.open) {
        scrollToCurrentCommit(details)
      }
    })
  }

  scrollToCurrentCommit(document)
})
