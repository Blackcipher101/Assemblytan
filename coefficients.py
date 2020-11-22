import math

# Python3 program to find tan(x) expansion 
  
# Function to find factorial of a number 
def fac(num): 
    if (num == 0): 
        return 1 
  
    # To store factorial of a number 
    fact = 1 
    for i in range(1, num + 1): 
        fact = fact * i 
  
    # Return the factorial of a number 
    return fact 
  
# Function to find tan(x) upto n terms 
def Tanx_expansion( x): 
    terms=10
    # To store value of the expansion 
    sum = 0 
  
    for i in range(1, terms + 1): 
  
        # This loops here calculate Bernoulli number 
        # which is further used to get the coefficient 
        # in the expansion of tan x 
        B = 0 
        Bn = 2 * i 
        for k in range(Bn + 1): 
            temp = 0 
            for r in range(0, k + 1): 
                temp = temp + pow(-1, r) * fac(k) * pow(r, Bn) / (fac(r) * fac(k - r)) 
  
            B = B + temp / ((k + 1)) 
  
        sum = sum + pow(-4, i) * (1 - pow(4, i))* B * pow(x, 2 * i - 1) / fac(2 * i) 
        print("{}".format(pow(-4, i) * (1 - pow(4, i))* B  / fac(2 * i) ))
  
    # Print the value of expansion 
    print("%.9f" %(sum)) 
  
# Driver code 
if __name__ == '__main__': 
    x = 0.523
  
    # Function call 
    Tanx_expansion( x) 

    print("Tan {} but by using inbuilt library: {}".format(x,math.tan(x)))