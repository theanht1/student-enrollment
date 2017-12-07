import Vue from 'vue/dist/vue.esm'
import Router from 'vue-router'

import Login from '../pages/Login'
import Index from '../pages/Index'
import Student from '../pages/Student'
import UniversityList from '../pages/UniversityList'
import StudentWish from '../pages/StudentWish'

Vue.use(Router)

const routes = [
  {
    path: '/',
    name: 'UniversityList',
    component: UniversityList,
  },
  {
    path: '/login',
    name: 'Login',
    component: Login,
  },
  {
    path: '/thi-sinh',
    name: 'Student',
    component: Student,
  },
  {
    path: '/nguyen-vong',
    name: 'StudentWish',
    component: StudentWish,
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
