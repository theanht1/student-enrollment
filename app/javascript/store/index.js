import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'

import auth from './auth'

Vue.use(Vuex)

const store = new Vuex.Store({
  modules: {
    auth,
  },

  strict: process.env.NODE_ENV !== 'production',
})

export default store
