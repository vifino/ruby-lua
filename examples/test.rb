#!/usr/bin/ruby

require 'pp'
require "../ext/lua"

lua = Language::Lua.new()
lua.load( "test.lua" )

i = 0;
print "BEGIN[#{i}]: -------------------------------------------------\n"
print "Lua Stack Size = #{lua.stack_size}\n"
lua.stack_dump
print "END[#{i}]:   -------------------------------------------------\n"

r = lua.call( "fact", 10 )
print "call( \"fact\", 10 ) -> #{r}\n"

r = lua.call( false, "fact", 8 )
print "call( false, \"fact\", 8 ) -> #{r}\n"

r = lua.call( true, "fact", 6 )
print "call( true, \"fact\", 6 ) -> #{r}\n"

r = lua.hello( )
print "hello( ) -> #{r}\n"

r = lua.var( "str" )
print "var( \"str\" ) -> #{r}\n"

r = lua.var( false, "num" )
print "var( false, \"num\" ) -> #{r}\n"

lua.var( "rdef", "Definied" )
r = lua.var( true, "rdef" )
print "var( true, \"rdef\" ) -> #{r}\n"

lua.eval( 'print "Hello from Lua !"' )

lua.eval <<LUA
    function norm (x, y)
      local n2 = x^2 + y^2
      return math.sqrt(n2)
    end
LUA

r = lua.norm( 2, 3 )
print "norm( 2, 3 ) -> #{r}\n"


print "BEGIN: -------------------------------------------------\n"
print "Lua Stack Size = #{lua.stack_size}\n"
lua.stack_dump
print "END:   -------------------------------------------------\n"

a = Array::new( )
a[0] = 30;
a[1] = "greg"
lua.var( "tbl", a )
r = lua.var( "tbl" )
print "BEGIN: -------------------------------------------------\n"
print "Lua Stack Size = #{lua.stack_size}\n"
lua.stack_dump
print "END:   -------------------------------------------------\n"

print "var( \"tbl\" ) -> "; pp r
print "BEGIN: -------------------------------------------------\n"
print "Lua Stack Size = #{lua.stack_size}\n"
lua.stack_dump
print "END:   -------------------------------------------------\n"

r.each { |k, v|
  puts "#{k} => #{v}"
}

h = Hash::new( )
h['greg'] = 30
h['arthur'] = 6
lua.var( "fml", h )
r = lua.var( "fml" )
r.each { |k, v|
  puts "#{k} => #{v}"
}
