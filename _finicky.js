module.exports = {
  defaultBrowser: "Safari",
  handlers: [
    {
      // open google meet in chrome
      match: ["meet.google.com/*"],
      browser: "Google Chrome",
    },
    {
      browser: "Google Chrome",
      match: ({ url }) => {
        return (
          url.host == "accounts.google.com" &&
          url.pathname == "/AccountChooser" &&
          /continue=https%3A%2F%2Fmeet\.google\.com/.test(url.search)
        );
      },
    },
  ],
};
