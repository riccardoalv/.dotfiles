; extends

; Captura strings baseadas no nome da variável (vertexShaderSource ou fragmentShaderSource)
((declaration
    declarator: (init_declarator
        declarator: (pointer_declarator (identifier) @var_name)
        value: (raw_string_literal (raw_string_content) @injection.content)))
 (#any-of? @var_name "vertexShaderSource" "fragmentShaderSource")
 (#set! injection.language "glsl"))

; Captura também se forem strings normais (não raw) com esses nomes
((declaration
    declarator: (init_declarator
        declarator: (pointer_declarator (identifier) @var_name)
        value: (string_literal (string_content) @injection.content)))
 (#any-of? @var_name "vertexShaderSource" "fragmentShaderSource")
 (#set! injection.language "glsl"))

