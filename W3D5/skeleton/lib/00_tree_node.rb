require "byebug"

class PolyTreeNode

    attr_reader :value, :parent, :children

    def initialize(value) 
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(new_parent)
        # ORDER IS IMPORTANT
        #remove self from curr parent
        #assign new parent
        if !self.parent.nil?
            self.parent.children.delete(self)
        end

        #WRONG: self.parent = new_parent
        #We haven't defined a setter yet
        @parent = new_parent

        if self.parent != nil
            self.parent.children << self
        end

        self
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        if !self.children.include?(child_node)
            raise "node is not a child"
        end
        child_node.parent = nil
    end

    def dfs(target)
        return self if self.value == target

        self.children.each do |child|
            val = child.dfs(target)
            return val if val != nil
        end

        nil
    end
 
    def bfs(target)
        queue = [self] 
        until queue.empty?
            node = queue.shift
            if node.value == target 
                return node 
            else
                queue.concat(node.children)
            end     
        end        
    end

end

