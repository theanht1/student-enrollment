import store from '../store'

export default {
  beforeRouteEnter(to, from, next) {
    if (to.name === 'Login' || store.state.auth.isAuthenticated) {
      next()
    } else {
      store.dispatch('getUser')
        .then(() => {
          next()
        }, () => {
          next()
        })
    }
  },
}
