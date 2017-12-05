import Vue from 'vue'
import Router from 'vue-router'

import Login from '../pages/Login'

Vue.use(Router)

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: Login,
  },
]

routes.push({
  path: '*',
  redirect: '/',
})

const router = new Router({
  routes,
  mode: 'history',
})

export default router
