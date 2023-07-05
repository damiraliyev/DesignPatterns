//
//  NutritionBuilder.swift
//
//
//  Created by Damir Aliyev on 19.02.2023.
//

import UIKit

class NutritionPlan {
    let calorieIntake: Int
    let proteins: Int
    let fats: Int
    let carbs: Int
    let mealPlans: [String]
    let goal: FitnessGoal
    
    let restrictions: [String]
    
    init(calorieIntake: Int, proteins: Int, fats: Int, carbs: Int, mealPlans: [String], goal: FitnessGoal, restrictions: [String]) {
        self.calorieIntake = calorieIntake
        self.proteins = proteins
        self.fats = fats
        self.carbs = carbs
        self.mealPlans = mealPlans
        self.goal = goal
        self.restrictions = restrictions
    }
    
}

enum FitnessGoal: String {
    case WeightLoss
    case WeightGain
    case Maintenance
}

protocol NutritionPlanBuilder {
    func setCalorieIntake() -> Self
    func setMacronutrientRatios() -> Self
    func setMealPlans() -> Self
    func setFitnessGoal() -> Self
    func setDietaryRestrictions() -> Self
    func build() -> NutritionPlan
}


class NutritionPlanDirector {
    var builder: NutritionPlanBuilder
    
    init(builder: NutritionPlanBuilder) {
        self.builder = builder
    }
    
    func setBuilder(builder: NutritionPlanBuilder) {
        self.builder = builder
    }
    
    func createNutritionPlan() {
        builder.build()
    }
}


class WeightLossNutritionBuilder: NutritionPlanBuilder {
    var calorieIntake: Int!
    var proteins: Int!
    var fats: Int!
    var carbs: Int!
    var mealPlans: [String]!
    var goal: FitnessGoal!
    var restrictions: [String]!
    
    func setCalorieIntake() -> Self {
        self.calorieIntake = 1800
        return self
    }
    
    func setMacronutrientRatios() -> Self {
        self.proteins = 90
        self.fats = 80
        self.carbs = 120
        return self
    }
    
    func setMealPlans() -> Self {
        self.mealPlans = ["Breakfest", "Dinner", "Supper"]
        return self
    }
    
    func setFitnessGoal() -> Self {
        self.goal = .WeightLoss
        return self
    }
    
    func setDietaryRestrictions() -> Self {
        self.restrictions = ["gluten free", "lactose free"]
        return self
    }
    
    func build() -> NutritionPlan {
        let nutritionPlan = NutritionPlan(calorieIntake: calorieIntake!, proteins: proteins!, fats: fats!, carbs: carbs!, mealPlans: mealPlans!, goal: goal!, restrictions: restrictions!)
        
        return nutritionPlan
    }
}

class WeightGainNutritionBuilder: NutritionPlanBuilder {
    var calorieIntake: Int!
    var proteins: Int!
    var fats: Int!
    var carbs: Int!
    var mealPlans: [String]!
    var goal: FitnessGoal!
    var restrictions: [String]!
    
    func setCalorieIntake() -> Self {
        self.calorieIntake = 2500
        return self
    }
    
    func setMacronutrientRatios() -> Self {
        self.proteins = 120
        self.fats = 120
        self.carbs = 180
        return self
    }
    
    func setMealPlans() -> Self {
        self.mealPlans = ["Breakfest", "Dinner", "Supper"]
        return self
    }
    
    func setFitnessGoal() -> Self {
        self.goal = .WeightGain
        return self
    }
    
    func setDietaryRestrictions() -> Self {
        self.restrictions = []
        return self
    }
    
    func build() -> NutritionPlan {
        let nutritionPlan = NutritionPlan(calorieIntake: calorieIntake!, proteins: proteins!, fats: fats!, carbs: carbs!, mealPlans: mealPlans!, goal: goal!, restrictions: restrictions!)
        
        return nutritionPlan
    }
}


class MaintenanceNutritionBuilder: NutritionPlanBuilder {
    var calorieIntake: Int!
    var proteins: Int!
    var fats: Int!
    var carbs: Int!
    var mealPlans: [String]!
    var goal: FitnessGoal!
    var restrictions: [String]!
    
    func setCalorieIntake() -> Self {
        self.calorieIntake = 2000
        return self
    }
    
    func setMacronutrientRatios() -> Self {
        self.proteins = 100
        self.fats = 100
        self.carbs = 150
        return self
    }
    
    func setMealPlans() -> Self {
        self.mealPlans = ["Breakfest", "Dinner", "Supper"]
        return self
    }
    
    func setFitnessGoal() -> Self {
        self.goal = .Maintenance
        return self
    }
    
    func setDietaryRestrictions() -> Self {
        self.restrictions = []
        return self
    }
    
    func build() -> NutritionPlan {
        let nutritionPlan = NutritionPlan(calorieIntake: calorieIntake!, proteins: proteins!, fats: fats!, carbs: carbs!, mealPlans: mealPlans!, goal: goal!, restrictions: restrictions!)
        
        return nutritionPlan
    }
}


class Director {
    var builder: NutritionPlanBuilder
    
    init(builder: NutritionPlanBuilder) {
        self.builder = builder
    }
    
    func setBuilder(builder: NutritionPlanBuilder) {
        self.builder = builder
    }
    
    func createNutritionPlan() -> NutritionPlan {
        builder.setCalorieIntake().setMacronutrientRatios().setMealPlans().setFitnessGoal().setDietaryRestrictions().build()
    }
}



let weightLossBuilder = WeightLossNutritionBuilder()

let director = Director(builder: weightLossBuilder)

let weightLossNutritionPlan = director.createNutritionPlan()
print("Weight loss Nutrition plan", weightLossNutritionPlan.goal.rawValue)


let weightGainBuilder = WeightGainNutritionBuilder()
director.setBuilder(builder: weightGainBuilder)

let weightGainNutritionPlan = director.createNutritionPlan()
print("Weight gain Nutrition plan", weightGainNutritionPlan.goal.rawValue)


let maintenanceBuilder = MaintenanceNutritionBuilder()
director.setBuilder(builder: maintenanceBuilder)

let maintenanceNutritionPlan = director.createNutritionPlan()
print("Maintenance plan", maintenanceBuilder.goal.rawValue)

