import { createApp } from 'vue'
import App from './App.vue'
import { createRouter, createMemoryHistory } from 'vue-router'

import CitesView from './views/CitesView.vue'
import EspecialitatsView from './views/EspecialitatsView.vue'
import FisioterapeutesView from './views/FisioterapeutesView.vue'
import CatalegView from './views/CatalegView.vue'

const routes = [
  { path: '/', name: 'Cites', component: CitesView },
  { path: '/especialitats', name: 'Especialitats', component: EspecialitatsView },
  { path: '/fisioterapeutes', name: 'Fisioterapeutes', component: FisioterapeutesView },
  { path: '/cataleg', name: 'Cataleg', component: CatalegView }
]

const router = createRouter({
  history: createMemoryHistory(),
  routes
})

const app = createApp(App)
app.use(router)
app.mount('#app')
