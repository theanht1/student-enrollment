import Vue from 'vue/dist/vue.esm'
import Element from 'element-ui'
import locale from 'element-ui/lib/locale/lang/en'

import 'element-ui/lib/theme-chalk/index.css'

import App from '../App.vue'
import router from '../router'

Vue.use(Element, { locale })

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))
  new Vue({
    ...App,
    router,
  }).$mount('app')
})
