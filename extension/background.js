// Configura um alarme para verificar eventos regularmente (a cada 5 minutos)
chrome.alarms.create("checkEvents", { periodInMinutes: 5 });

// Quando o alarme dispara, verifica eventos no servidor
chrome.alarms.onAlarm.addListener((alarm) => {
  if (alarm.name === "checkEvents") {
    fetch("http://localhost/acolhe-api/eventos.php")
      .then((response) => response.json())
      .then((data) => {
        if (data.success && data.eventos) {
          data.eventos.forEach((evento) => {
            chrome.notifications.create("", {
              type: "basic",
              title: "Novo Evento",
              message: evento.nome + " - " + evento.data,
              iconUrl: "icon.png"
            });
          });
        }
      })
      .catch((error) => console.error("Erro ao buscar eventos:", error));
  }
});
