return {
  {
	  'nvim-treesitter/nvim-treesitter', 
	  build=":TSUpdate",

    config = function () 
      require('nvim-ts-autotag').setup() 
    end

  },
}
