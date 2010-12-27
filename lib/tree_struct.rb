


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
     if i.class==String then next
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
        # removes outer [] from array
        elsif @list[0].class==Array 
          @list=unnest @list
          next
        # skip nil
        elsif  @list[0]==nil
           @list.delete_at 0
        end
        if @list.length ==1 then @a<<@list[0]; break
        end
      puts " I am in loading the array #{@a} \n"
    end
  end
  
  def get_nodes
    nodes @a
  end
  
  def get_edges
    edge_couples @a
  end
    
end
    

  
  