require "json"

$t="""
- 1
-
  - 2
  -
    - 3
    -
      - 4
      -
        - a


- a
-
  - b
  -
    - c
    -
      - d
      -
        - 1
        - 2
        - 3
        - 4
"""



$t2= """
- 1
-
  - 2
  -
    - 3
    -
      - 4

- a

- a
-
  - b
  -
    - c
    -
      - d
      -
        - 1
        - 2
        - 3
        - 4
        """





$t3="""
- 1
-
  - 2
  - 3
  - new box; select me, enter the text in the empty box and press controle to change me

- a"""



#doctest: testing Text2Box
#>> n=Text2Box.new $t2
#>> n.get_text_indent 
#FUSED TEXT:
#["- 1", "-", "  - 2", "  -", "    - 3", "    -", "      - 4", "- a", "- a", "-", "  - b", "  -", "    - c", "    -", "      - d", "      -", "        - 1", "        - 2", "        - 3", "        - 4"]
#OFFSET=2
#[0,1,2,3,0,0,1,2,3,4,4,4,4]
#=> "[[\" 1\",0],[\"   2\",1],[\"     3\",2],[\"       4\",3],[\" a\",0],[\" a\",0],[\"   b\",1],[\"     c\",2],[\"       d\",3],[\"         1\",4],[\"         2\",4],[\"         3\",4],[\"         4\",4]]"


class Text2Box
  
  attr_accessor :text
  
  def initialize text
    @text=text
  end
  
  def get_text_indent
    puts "IN TEXT INDENT"
    text=@text.split("\n")
    # get rid of empty lines that do not add to the YAML structure
    text.select!{|x| x if x.strip() !=""}
    fused_lines=[]
    text.each do |x|  
       if x.lstrip()[0] !="-" and fused_lines[-1]
         fused_lines[-1]=fused_lines[-1].strip() +x 
       else 
         fused_lines<<x 
       end
     end
    text=fused_lines
    puts "FUSED TEXT:\n #{text}"
    (text.collect! {|t| t.rstrip}).select! {|t| (t !="-" and t.strip() !="" and t.strip() !="-")}
    offset=text[1].index "-"
    offset=2 if offset==0
    puts "OFFSET=#{offset}"
    #print text
    #puts text
    boxes_indent=text.collect {|x| (x.index("-")/offset)}
    text.collect! {|x| x.delete "-"}
    puts "HERE #{boxes_indent} #{boxes_indent.class}"
    
    
    #puts boxes_indent.to_json
    text_indent=text.zip boxes_indent
    puts "#{text_indent}, #{text_indent.class}"
    
    return text_indent
  end
end





module Mani
 
  def unnest lst
    if lst.length==1 then return lst[0]
    else
      seed=lst[0]
      lst[1..-1].each do |i|
        puts i
        seed<<i
      end
    end
    seed
  end
     
  def nodes lst
    a=[]
    lst.flatten.each do |x|
      #puts "#{a} #{x} #{a.include? x}"
      a<<x unless a.include? x
    end
    a
  end


  def edge_couples lst
    a=[]
    lst.each do |i|
     if i.class != [].class then next
     end
     a<<(( [i[0]] * i[1].length).zip i[1])
    end
    a
  end

end

#doctest: testing NodesEdges
#>> n=NodesEdges.new
#>> n.get_edges
#=> [[["CANE", "Gatto"], ["CANE", "ELEFANTE"], ["CANE", "ippo"]], [["ippo", "SENSA"], ["ippo", "Capelli"]], [["Capelli", "CORIANDOLI"], ["Capelli", "MAAZ"]], [["MAAZ", "GATII"]], [["GATII", "PELOSI"], ["GATII", "MERDOS"], ["GATII", "PUZZONI"]], [["PUZZONI", "SUPER"], ["PUZZONI", "PUZZONISSIMI"]]]
#>> n.get_nodes
#=> ["CANE", "Gatto", "ELEFANTE", "ippo", "SENSA", "Capelli", "CORIANDOLI", "MAAZ", "GATII", "PELOSI", "MERDOS", "PUZZONI", "SUPER", "PUZZONISSIMI"]
#>> NodesEdges.new ["zfdfsf", "zfdfsf", ["THis is a test", ["minimum energy", ["maximum load", "kjkj", ["Massive power", nil, nil, "sdfsdfsd"]]]]] 

class NodesEdges
  
  attr_accessor :list,:a
  include Mani
  
  # list is a ruby version of a YAML structure
  def initialize list=["CANE", 
                        ["Gatto", "ELEFANTE", "ippo", ["SENSA", "Capelli"], ["CORIANDOLI", "MAAZ"], 
                        ["GATII", 
                        ["PELOSI", "MERDOS", "PUZZONI", 
                        ["SUPER", "PUZZONISSIMI"]]]]]
    @list=list
    # @list.flatten().each do  |x|
    #   if (x.index ":" and x.rstrip()[-1]!="'" and x.rstrip()[-1]!='"')
    #     puts "#{x} here it is"
    #     raise ":Error"
    #   end
    # end
    load_array
  end

  # @a=[["CANE", ["Gatto", "ELEFANTE", "ippo"]], "Gatto", "ELEFANTE", ["ippo", ["SENSA", "Capelli"]], "SENSA", ["Capelli", ["CORIANDOLI", "MAAZ"]], 
  # basically a structure with a each node and of each node with listed children
  def load_array 
    @a=[]
    while true
        # get rid of nil in list; 
        @list.select!{|x| x!= nil}
        # get rid of ints and floats
        # if (@list[0].class==Fixnum or  @list[0].class==Float)
        #   @list[0]="'#{@list[0]}'"
        #   next
        # elsif (@list[1].class==Fixnum or  @list[1].class==Float)
        #   @list[1]="'#{list[0]}'"
        #   next
        # node followed by array of nodes
        if (@list[0].class ==String and @list[1].class ==Array) 
          @a<<[@list[0],@list[1].select{|x| x if x.class==String}]
          @list.delete_at 0
          next
        #node followed by node
        elsif  (@list[0].class ==String and @list[1].class ==String)
          @a<<@list[0]
          @list.delete_at 0
          next
        # node followed by boolean operator; an error of YAML parsing
        elsif  (@list[0].class ==String and (@list[1] ==false or @list[1] ==true))
          @a<<@list[0]
          @list.delete_at 0
          next
        #removes outer [] from array
        elsif @list[0].class==Array 
          @list=unnest @list
          next
        # skip nil
        elsif  @list[0]==nil
           @list.delete_at 0
        end
        if @list.length ==1 then @a<<@list[0]; break
        end
      puts " I am in loading the array #{@a} trying to handle (#{@list[0]},#{@list[0].class},#{@list[1]},#{@list[1].class}) \n"
      puts "this is the list #{@list}"
    end
  end
  
  def get_nodes
    nodes @a
  end
  
  def get_edges
    edge_couples @a
  end
    
end
    

  
  