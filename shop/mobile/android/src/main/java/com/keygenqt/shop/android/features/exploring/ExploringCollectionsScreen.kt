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
package com.keygenqt.shop.android.features.exploring

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.ExperimentalMaterialApi
import androidx.compose.material.pullrefresh.pullRefresh
import androidx.compose.material.pullrefresh.rememberPullRefreshState
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import com.keygenqt.shop.android.components.base.AppPullRefreshIndicator
import com.keygenqt.shop.android.components.state.ErrorBody
import com.keygenqt.shop.android.features.exploring.elements.CollectionItem
import com.keygenqt.shop.android.routes.RouteProducts

/**
 * List collections page
 *
 * @param viewModel page view model
 */
@OptIn(ExperimentalMaterialApi::class)
@Composable
fun ExploringCollectionsScreen(
    navController: NavHostController,
    viewModel: ExploringCollectionsViewModel = hiltViewModel()
) {
    val collections by viewModel.collections.collectAsState(initial = null)
    val loading by viewModel.loading.collectAsState()
    val error by viewModel.error.collectAsState()

    val scrollState = rememberScrollState()
    val refreshState = rememberPullRefreshState(
        refreshing = loading,
        onRefresh = {
            viewModel.updateCollections()
        }
    )

    Box(
        Modifier
            .fillMaxSize()
            .pullRefresh(refreshState)
    ) {
        if (error != null) {
            ErrorBody()
        } else {
            if (!collections.isNullOrEmpty()) {
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .verticalScroll(state = scrollState)
                        .padding(vertical = 24.dp, horizontal = 16.dp),
                ) {
                    collections?.forEachIndexed { index, collectionModel ->
                        if (index != 0) {
                            Spacer(modifier = Modifier.size(20.dp))
                        }
                        CollectionItem(
                            model = collectionModel,
                            onClickCollection = { title, id ->
                                navController.navigate(
                                    RouteProducts.link(
                                        title = title,
                                        collectionID = id
                                    )
                                )
                            }
                        )
                    }
                }
            }
        }
        AppPullRefreshIndicator(
            state = refreshState,
        )
    }
}
