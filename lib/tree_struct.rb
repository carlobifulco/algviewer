


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


class NodesEdges
  
  attr_accessor :list,:a
  include Mani
  
  def initialize list=["CANE", 
                        ["Gatto", "ELEFANTE", "ippo", ["SENSA", "Capelli"], ["CORIANDOLI", "MAAZ"], 
                        ["GATII", 
                        ["PELOSI", "MERDOS", "PUZZONI", 
                        ["SUPER", "PUZZONISSIMI"]]]]]
    @list=list
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
      puts "#{@a} \n"
    end
  end
  
  def get_nodes
    nodes @a
  end
  
  def get_edges
    edge_couples @a
  end
    
end
    

  
  