import Vue from 'vue/dist/vue.esm'
import App from '../App.vue'

import router from '../router'

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))
  new Vue({
    ...App,
    router,
  }).$mount('app')

  // const app = new Vue({
  //   el: 'app',
  //   template: '<App/>',
  //   components: { App }
  // })
})
