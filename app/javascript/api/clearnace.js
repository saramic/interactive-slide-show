const xCsrfToken = () =>
  /<meta name="csrf-token" content="(.*)">/.exec(document.head.innerHTML)[1];

const signOut = () => {
  fetch("/sign_out", {
    method: "DELETE",
    headers: {
      "Content-type": "application/json",
      Accept: "application/json"
    },
    body: JSON.stringify({
      authenticity_token: xCsrfToken()
    })
  })
    .then(response => {
      if (response.ok) {
        return response;
      }
      if (response.redirected) {
        window.location.assign(response.url);
      } else {
        throw new Error(`Request rejected with status ${response.status}`);
      }
      return true;
    })
    .then(response => response.json())
    .then(response => {
      console.log(response);
    })
    .catch(error => {
      console.log(error);
    });
};

export { signOut, xCsrfToken };
