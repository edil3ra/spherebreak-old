module.exports = {
  files: {
	javascripts: {
	  joinTo: 'app.js'
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
