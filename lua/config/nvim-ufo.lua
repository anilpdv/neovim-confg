-- Minimal configuration for nvim-ufo
return {
  fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    -- You can customize how folded text is shown here
    return virtText
  end,
}
