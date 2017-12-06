import Vue from 'vue/dist/vue.esm'
import Router from 'vue-router'

import Login from '../pages/Login'
import Index from '../pages/Index'
import Setting from '../pages/Setting'

Vue.use(Router)

const routes = [
  {
    path: '/',
    name: 'Index',
    component: Index,
  },
  {
    path: '/login',
    name: 'Login',
    component: Login,
  },
  {
    path: '/settings',
    name: 'Setting',
    component: Setting,
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
