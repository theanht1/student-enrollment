import Vue from 'vue/dist/vue.esm'
import axios from 'axios'
import Element from 'element-ui'
import locale from 'element-ui/lib/locale/lang/en'

import 'element-ui/lib/theme-chalk/index.css'

import App from '../App.vue'
import router from '../router'
import store from '../store'

import getUser from '../mixins/getUser'

Vue.use(Element, { locale })
Vue.mixin(getUser)

axios.defaults.baseURL = '/api'

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))
  new Vue({
    ...App,
    router,
    store,
  }).$mount('app')
})
