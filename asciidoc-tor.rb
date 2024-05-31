#!/bin/ruby
require 'asciidoctor-pdf'
require 'asciidoctor/extensions'

# argument parser {{{
args = ARGV
input_file = nil
output_file = nil

args.each_with_index do |arg, index|
  case arg
  when '-i'
    input_file = args[index + 1] if index + 1 < args.length
  when '-o'
    output_file = args[index + 1] if index + 1 < args.length
  end
end

if input_file.nil?
  puts "Error: Input file is missing"
  exit
end

output_file ||= input_file.sub('.adoc', '.pdf')

# puts "Input file: #{input_file}"
# puts "Output file: #{output_file}"
# }}}

doc_author = "Hos Es"
doc_theme = "light"
doc_name = input_file

# # def lists {{{
# Asciidoctor::Extensions.register do
#     treeprocessor do
#         process do |doc_name|
#             (doc_name.find_by context: :dlist).each do |dlist|
#                 dlist.style = 'horizontal'
#             end
#             nil
#         end
#     end
# end
# # }}}

# template {{{
settings = {
    font_main: 'FreeSerif',
    font_code: 'FreeMono',
    font_size_main: 10.5,
    font_size_code: 8,
    font_size_caption: 9,
}

# list of fonts {{{
font_catalog = {
    'FreeSerif': {
        normal:      '/home/hos/.local/share/fonts/gnu-freefonts/serif/FreeSerif.ttf',
        bold:        '/home/hos/.local/share/fonts/gnu-freefonts/serif/FreeSerifBold.ttf',
        italic:      '/home/hos/.local/share/fonts/gnu-freefonts/serif/FreeSerifItalic.ttf',
        bold_italic: '/home/hos/.local/share/fonts/gnu-freefonts/serif/FreeSerifBoldItalic.ttf',
    },
    'FreeSans': {
        normal:      '/home/hos/.local/share/fonts/gnu-freefonts/sans/FreeSans.ttf',
        bold:        '/home/hos/.local/share/fonts/gnu-freefonts/sans/FreeSansBold.ttf',
        italic:      '/home/hos/.local/share/fonts/gnu-freefonts/sans/FreeSansOblique.ttf',
        bold_italic: '/home/hos/.local/share/fonts/gnu-freefonts/sans/FreeSansBoldOblique.ttf',
    },
    'FreeMono': {
        normal:      '/home/hos/.local/share/fonts/gnu-freefonts/mono/FreeMono.ttf',
        bold:        '/home/hos/.local/share/fonts/gnu-freefonts/mono/FreeMonoBold.ttf',
        italic:      '/home/hos/.local/share/fonts/gnu-freefonts/mono/FreeMonoOblique.ttf',
        bold_italic: '/home/hos/.local/share/fonts/gnu-freefonts/mono/FreeMonoBoldOblique.ttf',
    },
    'LiberationSerif': {
        normal:      '/home/hos/.local/share/fonts/liberation/LiberationSerif-Regular.ttf',
        bold:        '/home/hos/.local/share/fonts/liberation/LiberationSerif-Bold.ttf',
        italic:      '/home/hos/.local/share/fonts/liberation/LiberationSerif-Italic.ttf',
        bold_italic: '/home/hos/.local/share/fonts/liberation/LiberationSerif-BoldItalic.ttf',
    },
    'UbuntuMono': {
        normal:      '/home/hos/.local/share/fonts/ubuntu/UbuntuMono-R.ttf',
        bold:        '/home/hos/.local/share/fonts/ubuntu/UbuntuMono-B.ttf',
        italic:      '/home/hos/.local/share/fonts/ubuntu/UbuntuMono-RI.ttf',
        bold_italic: '/home/hos/.local/share/fonts/ubuntu/UbuntuMono-BI.ttf',
    },
    'CMUSerif': {
        normal:      '/usr/share/fonts/truetype/cmu/cmunrm.ttf',
        bold:        '/usr/share/fonts/truetype/cmu/cmunbx.ttf',
        italic:      '/usr/share/fonts/truetype/cmu/cmunti.ttf',
        bold_italic: '/usr/share/fonts/truetype/cmu/cmunbi.ttf',
    },
    'CMUMono': {
        normal:      '/usr/share/fonts/truetype/cmu/cmuntt.ttf',
        bold:        '/usr/share/fonts/truetype/cmu/cmuntb.ttf',
        italic:      '/usr/share/fonts/truetype/cmu/cmunit.ttf',
        bold_italic: '/usr/share/fonts/truetype/cmu/cmuntx.ttf',
    },
}
# }}}

# yaml {{{
theme_content = <<-YAML
extends: default
font:
  catalog:
    Noto Serif:
      normal:      #{font_catalog[:LiberationSerif][:normal]}
      bold:        #{font_catalog[:LiberationSerif][:bold]}
      italic:      #{font_catalog[:LiberationSerif][:italic]}
      bold_italic: #{font_catalog[:LiberationSerif][:bold_italic]}
    M+ 1mn:
      normal:      #{font_catalog[:UbuntuMono][:normal]}
      bold:        #{font_catalog[:UbuntuMono][:bold]}
      italic:      #{font_catalog[:UbuntuMono][:italic]}
      bold_italic: #{font_catalog[:UbuntuMono][:bold_italic]}
base:
  #font-family: #{settings[:font_main]}
  font-size: #{settings[:font_size_main]}
code:
  #font-family: #{settings[:font_code]}
  font-size: #{settings[:font_size_code]}
codespan:
  #font-family: #{settings[:font_code]} 
  font-size: #{settings[:font_size_caption]}
kbd:
  #font-family: #{settings[:font_code]} 
button:
  #font-family: #{settings[:font_main]} 
caption:
  font-color: #7a2518
  font-size: #{settings[:font_size_caption]}
heading:
  h1-font-size: floor($base_font_size * 2.6)
  h2-font-size: floor($base_font_size * 2.15)
  h3-font-size: round($base_font_size * 1.7)
  h4-font-size: $base_font_size_large
  h5-font-size: $base_font_size
  h6-font-size: $base_font_size_small
YAML

theme_file_path = 'custom-theme.yml'
File.open(theme_file_path, 'w') do |file|
    file.write(theme_content)
end
# }}}

# }}}

# options {{{
options = {
    backend: 'pdf',
    safe: :unsafe,
    doctype: :article, 
    # imagesdir: "imagedir",
    # to_file: 'main.pdf',
    # sourcemap: false,
    # standalone: false,

    attributes: {
        "imagesdir" => "images",
        "skip-front-matter" => true,
        "author" => doc_author,
        "icons" => "font",
        "icon-set" => "fi",
        'toc' => false,
        'sectnums' => false,
        # 'source-highlighter' => 'pygments',
        # 'pygments-style' => 'tango',
        'source-highlighter' => 'rouge',
        'rouge-style' => 'github',
        'pdf-themedir' => '.',  # Use the current directory for the styles
        'pdf-theme' => theme_file_path,  # The name of the custom theme file without the extension
    }
}
# }}}

options[:to_file] = output_file

Asciidoctor.convert_file doc_name, **options

File.delete(theme_file_path)

