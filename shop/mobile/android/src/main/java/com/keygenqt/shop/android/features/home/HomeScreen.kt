/*
 * Copyright 2023 Vitaliy Zarubin
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.keygenqt.shop.android.features.home

import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import com.keygenqt.shop.android.features.home.elements.HomeBody

/**
 * Home page, main for app
 *
 * @param viewModel page view model
 */
@Composable
fun HomeScreen(
    viewModel: HomeViewModel,
    onClickCategory: (String, Int) -> Unit,
    onClickCategories: () -> Unit,
    onClickCollections: () -> Unit
) {
    val loading by viewModel.loading.collectAsState()
    val categories by viewModel.categories.collectAsState(null)

    HomeBody(
        loading = loading,
        categories = categories,
        onRefresh = {
            viewModel.updateCategories()
        },
        onClickCategory = onClickCategory,
        onClickCategories = onClickCategories,
        onClickCollections = onClickCollections
    )
}
