


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
class NodesEdges
  
  attr_accessor :list,:a
  include Mani
  
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

  def load_array 
    @a=[]
    while true
        if (@list[0].class ==String and @list[1].class ==Array) 
          @a<<[@list[0],@list[1].select{|x| x if x.class==String}]
          @list.delete_at 0
          next
        elsif  (@list[0].class ==String and @list[1].class ==String)
          @a<<@list[0]
          @list.delete_at 0
          next
        elsif @list[0].class==Array then
          @list=unnest @list
          next
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
    

  
  