module.exports = {
  files: {
	javascripts: {
	  joinTo: 'app.js'
	},

    stylesheets: {
	  joinTo: 'style.css'
	}
  },

  paths: {
    public: 'public',
    watched: ['app'],     
  },
  
  plugins: {
	elmBrunch: {
      mainModules: ['app/elm/Main.elm'],
	  outputFolder: 'public',
      outputFile: 'elm.js',
      makeParameters : ['--warn'],
	},
  }
  
}
