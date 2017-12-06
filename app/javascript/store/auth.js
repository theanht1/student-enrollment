import Vue from 'vue'
import axios from 'axios'

const auth = {
  state: {
    user: {
      id: -1,
    },

    isAuthenticated: false,
  },

  mutations: {
    setUser(state, user) {
      Vue.set(state, 'user', user)
    },

    setAuthenticate(state, value) {
      Vue.set(state, 'isAuthenticated', value)
    },
  },

  actions: {
    login({ commit }, user) {
      commit('setUser', user)
      commit('setAuthenticate', true)
    },

    getUser({ dispatch }) {
      return axios.get('/me')
        .then(({ data }) => {
          dispatch('login', data)
        })
    },

    logout({ commit }) {
      return axios.delete('/logout')
        .then(() => {
          commit('setUser', { id: -1 })
          commit('setAuthenticate', false)
        })
    },
  },
}

export default auth
