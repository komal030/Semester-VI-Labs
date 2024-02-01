class PowerCalculator:
    def my_pow(self, x, n):
        result = 1
        current_power = x

        while n > 0:
            if n % 2 == 1:
                result *= current_power
            current_power *= current_power
            n //= 2

        return result

if __name__ == "__main__":
    calculator = PowerCalculator()
    
    x = float(input("Enter the base (x): "))
    n = int(input("Enter the exponent (n): "))

    result = calculator.my_pow(x, n)
    print(f"The result of {x}^{n} is: {result}")
