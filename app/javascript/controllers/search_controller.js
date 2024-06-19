import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list", "item", "noResult", "searchIcon", "clearButton"]

  connect() {
    this.noResultTarget.classList.add('hidden')
    this.updateIcons()
  }

  search() {
    const query = this.inputTarget.value.toLowerCase()

    let hasResult = false

    this.itemTargets.forEach(item => {
      const username = item.dataset.username.toLowerCase()
      if (username.includes(query)) {
        item.style.display = "flex"
        hasResult = true
      } else {
        item.style.display = "none"
      }
    })

    if (query === "") {
      this.clearSearch()
    } else {
      if (hasResult) {
        this.noResultTarget.classList.add('hidden')
      } else {
        this.noResultTarget.classList.remove('hidden')
      }
    }

    this.updateIcons()
  }

  clearSearch() {
    this.inputTarget.value = ""
    this.itemTargets.forEach(item => item.style.display = "flex")
    this.noResultTarget.classList.add('hidden')
    this.updateIcons()
  }

  updateIcons() {
    if (this.inputTarget.value === "") {
      this.searchIconTarget.classList.remove('hidden')
      this.clearButtonTarget.classList.add('hidden')
    } else {
      this.searchIconTarget.classList.add('hidden')
      this.clearButtonTarget.classList.remove('hidden')
    }
  }
}
