<template>
  <div id="app">
    <header class="header">
      <h1>Gestor de CITES - Fisioteràpia</h1>
    </header>
    <main class="main">
      <router-view />
    </main>
  </div>
</template>

<script setup>
// App principal amb Router
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
  background-color: #f5f5f5;
  color: #333;
  line-height: 1.6;
}

#app {
  min-height: 100vh;
}

.header {
  background-color: #2c3e50;
  color: white;
  padding: 1rem 2rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.header h1 {
  font-size: 1.5rem;
  font-weight: 600;
}

.main {
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}
</style>
