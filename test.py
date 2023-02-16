class computer:
    def __init__(self):
        self.name = 'Dell'
        self.age = 28

    def apple(): #self as parameter is missing
        print('MacBook')

d = computer()
d.apple() #here the ‘d.’ instance is passed to apple()