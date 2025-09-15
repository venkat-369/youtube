// Search functionality
document.getElementById("searchBtn").addEventListener("click", () => {
  const query = document.getElementById("searchInput").value.toLowerCase();
  const videos = document.querySelectorAll(".video-card");

  videos.forEach(video => {
    const title = video.querySelector("h3").textContent.toLowerCase();
    if (title.includes(query)) {
      video.style.display = "block";
    } else {
      video.style.display = "none";
    }
  });
});

