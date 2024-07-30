document.addEventListener("DOMContentLoaded", () => {
    const homeLink = document.getElementById("home-link");
    const salasLink = document.getElementById("salas-link");
    const logoLink = document.getElementById("logo-link");
    
    const homeSection = document.getElementById("home");
    const salasSection = document.getElementById("salas");
    const salaDetalheSection = document.getElementById("sala-detalhe");
  
    const showHome = () => {
      homeSection.style.display = "block";
      salasSection.style.display = "none";
      salaDetalheSection.style.display = "none";
    };
  
    const showSalas = () => {
      homeSection.style.display = "none";
      salasSection.style.display = "block";
      salaDetalheSection.style.display = "none";
    };
  
    homeLink.addEventListener("click", (e) => {
      e.preventDefault();
      showHome();
    });
  
    salasLink.addEventListener("click", (e) => {
      e.preventDefault();
      showSalas();
    });
  
    logoLink.addEventListener("click", (e) => {
      e.preventDefault();
      showHome();
    });
  
    // Inicialize na página Home
    showHome();
  });  