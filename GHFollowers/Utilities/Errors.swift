//
//  Errors.swift
//  GHFollowers
//
//  Created by Begench on 12.04.2025.
//
import Foundation

enum CHError: String, Error{
    case invalidUsername = "This username created an invalid request. Please try again"
    case invalidResponse = "Unable to complate the responce. Please check internet connection and try again"
    case unableRequest = "Invalid response from the server. Please try again"
    case invalidData = "the data recieved from server was invalid. Please try again"
    case invalidFavorites = "Cannot get followers. Please try again"
    case invalidSavingFavorites = "Cannot add follower. Please try again"
    case allreadyInFavorites = "User is already in favorites"
}
